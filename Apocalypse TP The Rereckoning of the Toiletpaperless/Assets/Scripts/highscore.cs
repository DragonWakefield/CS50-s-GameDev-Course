using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class highscore : MonoBehaviour
{
    Text highScoreText;
    // Start is called before the first frame update
    void Start()
    {
        highScoreText = GetComponent<Text>();
    }

    // Update is called once per frame
    void Update()
    {
        int highScore;
        if(  PlayerPrefs.GetInt("High Score", 0) > score_keeper.total_score)
        {
            highScore = PlayerPrefs.GetInt("High Score", 0);
            
          
            PlayerPrefs.SetInt("High Score", highScore);
        }
        else{
            highScore = score_keeper.total_score;
            
          
            PlayerPrefs.SetInt("High Score", highScore);
        }

        highScoreText.text = "High Score: " + highScore;
    }
}
