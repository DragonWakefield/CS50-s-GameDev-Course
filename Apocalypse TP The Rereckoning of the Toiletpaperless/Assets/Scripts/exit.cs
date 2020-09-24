using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
public class exit : MonoBehaviour
{
    public Button ex;
  

    // Start is called before the first frame update
    void Start()
    {
        Button btn = ex.GetComponent<Button>();
		btn.onClick.AddListener(TaskOnClick);
    }
    void Update() {
        if (Input.GetKey("escape"))
        {
            Application.Quit();
        }
    }
    void TaskOnClick(){

        Application.Quit();
    
    }

}
