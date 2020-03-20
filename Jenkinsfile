import org.jenkinsci.plugins.pipeline.modeldefinition.Utils

def default_env = [
    'TF_IN_AUTOMATION=true', 
    'TF_INPUT=false'
]
def file = readFile file:"accounts"
def lines = file.readLines()
def files

node {
    checkout scm
    def files = findFiles(glob: 'accounts/*')

    for (int i; files.size(); i++) {
        file = readFile file:"${files[i]}"

        docker.image('hashicorp/terraform:0.12.23').inside('--entrypoint=""') {
            withEnv(default_env + file.readLines()) {

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