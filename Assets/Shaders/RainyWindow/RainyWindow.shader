Shader "Unlit/RainyWindow"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Size("Size", float) = 1
        _T("T", float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Size, _T;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            float N21(float2 p) {
                p = frac(p * float2(123.34, 345.45));
                p += dot(p, p + 34.345);
                return frac(p.x * p.y);
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float t = fmod(_Time.y + _T, 7200);

                float4 col = 0;

                float2 aspect = float2(2, 1);
                float2 uv = i.uv * _Size * aspect;
                uv.y += t * 0.25;
                float2 gv = frac(uv) - 0.5;
                float2 id = floor(uv);

                float n = N21(id);
                t += n * 6.2831;

                float w = i.uv.y * 10;
                float x = (n - 0.5) * 0.8;
                x += (0.4 - abs(x)) * sin(3 * w) * pow(sin(w), 6) * 0.45;

                float y = -sin(t + sin(t+sin(t)*0.5))*0.45;
                y -= (gv.x - x) * (gv.x - x);

                float2 dropPos = (gv - float2(x, y)) / aspect;
                float drop = smoothstep(0.05, 0.03, length(dropPos));

                float2 trailPos = (gv - float2(x, t * 0.25)) / aspect;
                trailPos.y = (frac(trailPos.y * 8) - 0.5) / 8;
                float trail = smoothstep(0.03, 0.01, length(trailPos));
                trail *= smoothstep(-0.05, 0.05, dropPos.y);
                trail *= smoothstep(-0.5, y, gv.y);

                col += trail;
                col += drop;

                if (gv.x > 0.48 || gv.y > 0.49) {
                    col = float4(1, 0, 0, 1);
                }

                return col;
            }
            ENDCG
        }
    }
}
