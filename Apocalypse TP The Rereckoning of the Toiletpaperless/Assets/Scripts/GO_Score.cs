using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class GO_Score : MonoBehaviour
{
    public Text endscore;
    public bool added;
    // Start is called before the first frame update
    void Start()
    {
        added = false;
    }

    // Update is called once per frame
    void Update()
    {
        if (!added){
            int lifetimeTp = PlayerPrefs.GetInt("lifetime", 0) + score_keeper.total_score;
            PlayerPrefs.SetInt("lifetime", lifetimeTp);
           
            added = true;
        }
        endscore.text = "Total TP: " + score_keeper.total_score;
    }
}
