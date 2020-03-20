import org.jenkinsci.plugins.pipeline.modeldefinition.Utils

def default_env = [
    'TF_IN_AUTOMATION=true', 
    'TF_INPUT=false'
]

node {
    checkout scm

    files = sh(returnStdout: true, script: 'ls').trim().split( "\\r?\\n" )

    for (fileName in files) {
        lines = readFile(file: fileName).trim().split( "\\r?\\n" )

        docker.image('hashicorp/terraform:0.12.23').inside('--entrypoint=""') {
            withEnv(default_env + lines) {

                stage('initialize') {
                    sh 'terraform init'
                }
                stage('plan') {
                    sh 'terraform plan'
                }
                stage('apply') {
                    if (env.BRANCH_NAME == 'master') {
                        sh 'terraform apply -auto-approve'
                    } else {
                        Utils.markStageSkippedForConditional('apply')
                    }
                }
            }
        }
    }

}