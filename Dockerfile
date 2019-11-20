FROM openwhisk/action-nodejs-v10:latest

RUN npm install ibm-watson ibm-cloud-sdk-core
