#!/usr/bin/env sh

carml_version="v21.1.0"
git_url="https://github.com/meejah/carml.git"
tag_key="9D5A2BD5688ECB889DEBCD3FC2602803128069A7"

## https://meejah.ca/meejah.asc
## https://github.com/meejah/carml/blob/master/meejah.asc

me="${0##*/}"

msg(){
  msg_type="${1}"
  msg_text="${2}"
  printf %s"${me}: [${msg_type}]: ${msg_text}\n"
  case "${msg_type}" in err*) exit 1;; esac
}

if test -d carml-git; then
  git -C carml-git checkout master
  git -C carml-git pull --ff-only || msg err "git pull failed"
else
  git clone "${git_url}" carml-git || msg err "git clone failed"
fi

cd carml-git || msg err "changing to git directory failed"

git verify-tag "${carml_version}" 2>&1 \
| grep -e "${tag_key}" -e "Good signature from \"meejah <meejah@meejah.ca>\"" \
|| msg err "git tag verification failed"
msg info "tag verification suceeded"

git -c advice.detachedHead=false checkout "${carml_version}"

python3 setup.py build
## remove old dir to be sure no file names changed and unwanted files stay
rm -rf ../usr/lib/python3/dist-packages/carml
mkdir -p ../usr/lib/python3/dist-packages/carml
cp -r build/lib/carml/* ../usr/lib/python3/dist-packages/carml/

msg info "build succeeded"
exit 0
