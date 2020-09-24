using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
public class nextLevel : MonoBehaviour
{
    public Button cont;
  

    // Start is called before the first frame update
    void Start()
    {
        Button btn = cont.GetComponent<Button>();
		btn.onClick.AddListener(TaskOnClick);
    }
    void TaskOnClick(){

        score_keeper.level += 1;
        score_keeper.max_tp += ZombieSpawner.zombie_counter;
        
        
        score_keeper.score = 1;

        
        SceneManager.LoadScene("PlayScene");

        
    }

    


}