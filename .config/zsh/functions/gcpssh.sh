# GCP ssh does not work properly with certain terminals.
# This seems to be becuase it only understands certain terminal types.
# Thus 'alacrity' will give weird issues (like no backspace).
# This can be fixed by installing support in /usr/share/terminfo/
# But an easier way is to set the TERM env var to 'linux' instead (it's close enough).
# To make this easy so I don't have to remember every time, this function does it all for me.

# Usage
# gcpssh <vm id> --project=<gcp project id> --zone <zone> --internal-ip

gcpssh() {
    gcloud compute ssh $@ -- 'export TERM=linux && bash'
}
