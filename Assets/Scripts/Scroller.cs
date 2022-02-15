using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Scroller : MonoBehaviour
{
    public Material material;

    float value = 0;

    private void Awake()
    {
        StartCoroutine(Scrolling());
    }

    private IEnumerator Scrolling()
    {
        while (true)
        {
            material.SetFloat("_ScrollValue", value);
            value += 0.01f;
            yield return new WaitForFixedUpdate();
        }
    }

    public void Test()
    {

    }
}
