function lbinit() {
 local lb_path=${LINK_BAR_PATH:-"/link_bar"}
 mkdir -p ~"$lb_path"
 touch ~"$lb_path/links"

 echo ~"$lb_path/links"
}

function lbadd() {
 local links_file="$(lbinit)"

 if [[ -n "$(sed -n "/alias{$1}-link{.*}/p" "$links_file")" ]]; then
 echo -n "Alias already eixsts do you want to replace (y/n): "
 read confirm

 if [ "$confirm" != "y" ]; then
  return 0
 fi

 sed -i "" "s/alias{$1}-link{.*}/alias{$1}-link{$2}-profile{$3}/" $links_file
 else
 echo "alias{$1}-link{$2}-profile{$3}" >> $links_file
 fi
}

function lbls(){
 local links_file="$(lbinit)"
 sed -n "s/alias{\(.*\)}-link{\(.*\)}-profile{\(.*\)}/\1 $([ ${1:-""} = "-l" ] && echo "\2 \3")/p" $links_file
}

function lbopen() {
 local links_file="$(lbinit)"
 local link="$(sed -n "s/alias{$1}-link{\(.*\)}-profile{.*}/\1/p" $links_file)"
 local profile="$(sed -n "s/alias{$1}-link{.*}-profile{\(.*\)}/\1/p" $links_file)"
 profile=${2:-${profile:-$LB_DEFAULT_PROFILE}}

 # To open in Chrome
 # open -a "Google Chrome" -n --args --profile-directory=$profile $link

 # To open in ARC
 if [ -n "$profile" ]; then
  arc-cli select-space-name $profile
 fi

 arc-cli new-tab $link
}
