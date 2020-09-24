using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class GO_level : MonoBehaviour
{
    public Text endLevel;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        endLevel.text = "Level: " + score_keeper.level;
        
    }
}
