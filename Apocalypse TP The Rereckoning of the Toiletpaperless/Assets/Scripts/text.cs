using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class text : MonoBehaviour
{

    public Text scorebox;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        scorebox.text = "" + score_keeper.score + "/" + score_keeper.max_tp;
        
    }
}
