Shader "Custom/Toon"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _OutLinePower("OutLinePower", Range(0.001, 0.01)) = 0.01
        _OutLineColor("OutLine Color", Color) = (0,0,0,0)
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        cull front
        LOD 200


        CGPROGRAM
        #pragma surface surf nolight vertex:vert noshadow 
        #pragma target 3.0

        float4 _OutLineColor;
        float _OutLinePower;

        void vert(inout appdata_full v) {
            v.vertex.xyz = v.vertex.xyz + v.normal.xyz * _OutLinePower;
        }

        struct Input
        {
            float4 color:COLOR;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {

        }

        float4 Lightingnolight(SurfaceOutput s, float3 lightDir, float atten) {
            return float4(_OutLineColor.rgb, 1);
        }

        ENDCG

        
        cull back
        CGPROGRAM
        #pragma surface surf Toon noambient
        sampler2D _MainTex;

        struct Input {
            float2 uv_MainTex;
            float3 viewDir;
        };

        void surf(Input IN, inout SurfaceOutput o) {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;

            o.Alpha = c.a;
        }

        float4 LightingToon(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten) {
            float ndot = dot(s.Normal, viewDir) * 0.5 + 0.5;
            
            ndot *= 5;
            ndot = ceil(ndot)/5;
            ndot -= 0.2;

            return float4(ndot * s.Albedo, 1);
        }


        ENDCG
        
    }
    FallBack "Diffuse"
}
