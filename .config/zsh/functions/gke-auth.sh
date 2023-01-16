# Simple tool for switching and authenticating between different GKE clusters.
# It assumes that you already have some gcloud configs set up.
# Works great when switching between different user accounts and different GCP projects.

# Choose which gcloud config to switch to, optionally reauthenticate user, choose which gke cluster to authenticate (automatically sets the kubeconfig to that ctx)

gke-auth () {
    gcpe l
    if [ $# -eq 1 ]; then
        if [ $1 = "l" ]; then # Login
            gcloud auth login
        fi
	fi
    gcloud container clusters get-credentials $(gcloud container clusters list --format json | jq -r '.[].name' | fzf) --region australia-southeast1 --internal-ip
}

alias gkea='gke-auth'
