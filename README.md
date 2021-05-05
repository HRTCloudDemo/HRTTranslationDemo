# HRTTranslationDemo

Build and publish the custom Docker image into your DockerHub account
```
./buildAndPush.sh <dockerhub-repo>/cloud-functions-ai-translator:v1
```

Adjust the local config file and enter your AI Language Translator API key
```
vi config/ai-params.json
```

Login to the IBM Cloud
```
ibmcloud --login
```

Create the Package
```
ibmcloud fn package create hrt-demo 
```

Create the Cloud Functions Actions 

detect-language:
```
ibmcloud fn action update hrt-demo/detect-language --kind nodejs:default src/detect-language.js --param-file config/ai-params.json --web true
```

translate:
```
ibmcloud fn action update hrt-demo/translate --kind nodejs:default src/translate.js -P config/ai-params.json --web true
```

Create a sequence to bind pipe both actions together:

```
ibmcloud fn action create hrt-demo/identify-and-translate --sequence hrt-demo/detect-language,hrt-demo/translate --web true
```


Test the Action

* via CLI
```
ibmcloud fn action invoke hrt-demo/detect-language -p text "hi there. this is awesome"
```

```
ibmcloud fn action invoke hrt-demo/identify-and-translate -p text "Wer hat and der Uhr gedreht? Ist es wirklich schon so spät?" -r
```

* Or via URL: https://eu-de.functions.cloud.ibm.com/api/v1/web/0c062c95-d5e8-4e2b-bd45-f7cb289d9813/hrt-demo/detect-language?text=hi%20this%20is%20awesome


## Further information

[Language Translator API](https://cloud.ibm.com/apidocs/language-translator?code=node#identify-language)
[HowTo extend Cloud Functions Runtime images](https://github.com/apache/openwhisk/blob/master/docs/actions-docker.md#extending-existing-runtimes)
