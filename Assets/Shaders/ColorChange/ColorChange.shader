Shader "Custom/ColorChange"
{
    Properties
    {
        _Angle("Angle", Range(0, 360)) = 0
    }
        SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert noambient

        #pragma target 3.0

        float _Angle;

        struct Input
        {
            float3 viewDir;
        };


        void surf (Input IN, inout SurfaceOutput o)
        {
            float3 color = saturate(float3(sin(_Angle), sin(_Angle + 120), sin(_Angle + 240)) * 1.5 + 0.75);
            o.Emission = color;
            o.Alpha = 1;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
