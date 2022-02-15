Shader "Custom/Fire"
{
    Properties
    {
        _Wrinkle("Wrinkle", Range(0, 1)) = 0
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2("Albedo (RGB)", 2D) = "black" {}
    }
        SubShader
    {
        Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }

        CGPROGRAM
        #pragma surface surf Standard alpha:fade

        float _Wrinkle;
        sampler2D _MainTex;
        sampler2D _MainTex2;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 d = tex2D(_MainTex2, float2(IN.uv_MainTex2.x, IN.uv_MainTex2.y - _Time.y));
            //d.rgb = d.rgb * (1+_Wrinkle);
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex + d.r *0.5);
            //o.Albedo = c.rgb;
            o.Emission = c.rgb ;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
