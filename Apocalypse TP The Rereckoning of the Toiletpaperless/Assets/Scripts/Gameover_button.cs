using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
public class Gameover_button : MonoBehaviour
{
    public Button restart;
  

    // Start is called before the first frame update
    void Start()
    {
        Button btn = restart.GetComponent<Button>();
		btn.onClick.AddListener(TaskOnClick);
    }
    void TaskOnClick(){

        score_keeper.level = 0;
        score_keeper.max_tp = 10;
        score_keeper.score = 1;
        score_keeper.total_score = 0;
        SceneManager.LoadScene("PlayScene");

        
    }

    


}
