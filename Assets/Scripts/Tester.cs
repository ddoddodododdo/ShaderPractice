using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Tester : MonoBehaviour
{
    Color[] colors = { Color.red, Color.green, Color.blue };

    private void Update()
    {
        GetComponent<MeshRenderer>().material.color = colors[Random.Range(0, 3)];
    }
}

