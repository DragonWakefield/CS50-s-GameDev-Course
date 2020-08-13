using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LoadSceneOnInput : MonoBehaviour {

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		Scene scene = SceneManager.GetActiveScene();
		if ((Input.GetAxis ("Submit") == 1) && (scene.name == "Title")) {
			SceneManager.LoadScene ("Play");
		} else if (Input.GetAxis ("Submit") == 1 && scene.name == "Game Over") {
			SceneManager.LoadScene ("Title");
		}
	}
}
