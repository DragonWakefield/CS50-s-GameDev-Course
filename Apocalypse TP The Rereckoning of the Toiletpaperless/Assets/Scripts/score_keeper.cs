using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
public class score_keeper : MonoBehaviour
{

    public static int score=1;
    public static int total_score = 1;
    public static int max_tp=10;
    public static int level=1;
    
    
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {   
        
        if(score == 0){
            
            SceneManager.LoadScene("GameOver");
        }
        else if (score == max_tp){
            SceneManager.LoadScene("Progress");
        }
    }
}
