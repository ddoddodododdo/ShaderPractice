Shader "Custom/Refraction"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
        SubShader
    {
        Tags { "RenderType" = "Transaparent" "Queue"="Transparent" }
        LOD 200

        GrabPass{}

        CGPROGRAM
        #pragma surface surf Lambert
        #pragma target 3.0

        sampler2D _GrabTexture;
        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float4 screenPos;
        };


        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            float2 screenUV = IN.screenPos.xyz / IN.screenPos.w;
            float2 add = frac(c.rg * _Time.y)*0.02;

            o.Albedo = tex2D(_GrabTexture, screenUV + add);

            //o.Emission = tex2D(_GrabTexture, screenUV + c.r * 0.1);
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
