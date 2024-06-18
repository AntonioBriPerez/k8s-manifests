# Instrucciones
Tarda un poco en desplegar y estar listo, entrar al pod que despliega y ejecutar cat /var/jenkins_home/secrets/initialAdminPassword

Los plugins se instalaran, daran errores, reiniciar jenkins desde la interfaz y debería arreglarse.

kubectl get secrets jenkins-admin -o=jsonpath='{.data.token}' -n devops-tools | base64 -D