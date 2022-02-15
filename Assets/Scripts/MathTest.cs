using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MathTest : MonoBehaviour
{
    public GameObject pointPrefab;
    public GameObject point;

    float x, y;
    int angle;
    Vector3 pos;
    void Start()
    {
        Application.targetFrameRate = 144;
        pos = Vector3.zero;
        angle = 0;


    }

    private void Update()
    {

    }

    void MoveCircle()
    {
        pos.x = GetSin(angle) * 3;
        pos.z = GetCos(angle) * 2;

        point.transform.position = pos;

        angle = angle += 2 % 360;
    }

    void SpawnTest()
    {
        for (int angle = 0; angle < 360; angle++)
        {
            pos.x = GetCos(angle)/2;
            pos.z = GetSin(angle);

            Instantiate(point, pos, Quaternion.identity);
        }
    }

    float GetCos(float angle)
    {
        return Mathf.Cos(GetRadian(angle));
    }

    float GetSin(float angle)
    {
        return Mathf.Sin(GetRadian(angle));
    }

    float GetRadian(float angle)
    {
        return Mathf.PI * angle / 180; 
    }

    
}
