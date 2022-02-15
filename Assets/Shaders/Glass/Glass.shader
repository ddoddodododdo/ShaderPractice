Shader "Custom/Glass"
{
    Properties
    {
        _MainTex ("Pattern", 2D) = "white" {}
        _Color("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
        cull off
        LOD 200

        CGPROGRAM
        #pragma surface surf noLight alpha:fade

        #pragma target 3.0

        sampler2D _MainTex;
        float4 _Color;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            c.rgb = (c.r + c.g + c.b) / 3;

            o.Albedo = c.rgb;
            o.Alpha = _Color.a;
        }

        float4 LightingnoLight(SurfaceOutput s, float3 lightDir, float atten) {

            return float4(s.Albedo, s.Alpha);
        }

        ENDCG
    }
    FallBack "Diffuse"
}
