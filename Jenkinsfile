import org.jenkinsci.plugins.pipeline.modeldefinition.Utils

node {
    checkout scm
    docker.image('hashicorp/terraform:0.12.23').inside('--entrypoint=""') {
        withEnv(['TF_IN_AUTOMATION=true', 'TF_INPUT=false']) {
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