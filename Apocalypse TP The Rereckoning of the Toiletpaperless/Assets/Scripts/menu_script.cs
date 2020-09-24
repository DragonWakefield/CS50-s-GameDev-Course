using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
public class menu_script : MonoBehaviour
{
    public Button menu;
  

    // Start is called before the first frame update
    void Start()
    {
        Button btn = menu.GetComponent<Button>();
		btn.onClick.AddListener(TaskOnClick);
    }
    void TaskOnClick(){

        SceneManager.LoadScene("menu");
    
    }

    


}
