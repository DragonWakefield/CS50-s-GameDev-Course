using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class lifetime : MonoBehaviour
{
    Text lifetimeText;
    private int lifetimeTP = 0;
    // Start is called before the first frame update
    void Start()
    {
        lifetimeText = GetComponent<Text>();
    }

    // Update is called once per frame
    void Update()
    {
        
        lifetimeText.text = "Lifetime total of TP: " + PlayerPrefs.GetInt("lifetime", 0);
    }
}
