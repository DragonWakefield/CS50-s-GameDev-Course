using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
public class Transition : MonoBehaviour
{
    public Button start;
    // Start is called before the first frame update
    void Start()
    {
        Button btn = start.GetComponent<Button>();
		btn.onClick.AddListener(TaskOnClick);
    }

    void TaskOnClick(){

        SceneManager.LoadScene("PlayScene");
        
    }
    
}
