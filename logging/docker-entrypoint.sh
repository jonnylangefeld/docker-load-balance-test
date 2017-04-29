#!/bin/bash

# The following two methods are ripped from alpine's syslog-ng package.
# This allows us (and a user) to customize the config with snippets.
grep_syslog_conf_entries() {
  local section="$1" FN filelist
  grep -v '^#' /etc/syslog-ng/syslog-ng-${section}.std
  filelist=$(find /etc/syslog-ng/ -maxdepth 1 -type f -name "syslog-ng-${section}.*" | grep -Ev ".backup|.std|~")
  if [ $? -eq 0 ]
  then
    for FN in ${filelist}
    do
      grep -v '^#' $FN
    done
  fi
}

update() {
  local fname='/etc/syslog-ng/syslog-ng.conf'
  local f_tmp="/etc/syslog-ng/syslog-ng.conf.$$"
  for ng_std in options source destination filter log
  do
    [ -f /etc/syslog-ng/syslog-ng-${ng_std}.std ] || exit 1
  done
  {
    # create options entries
    grep_syslog_conf_entries plugins
    echo "options {"
    grep_syslog_conf_entries options
    echo "};"
    # create source entries
    echo "source s_all {"
    grep_syslog_conf_entries source
    echo "};"
    # create destination entries
    grep_syslog_conf_entries destination
    # create filter entries
    grep_syslog_conf_entries filter
    # create log entries
    grep_syslog_conf_entries log
  } > $f_tmp
  cp -p $f_tmp $fname
  rm -f $f_tmp
}

update

echo Starting "$@"
exec "$@"
