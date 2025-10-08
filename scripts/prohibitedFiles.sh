#!/bin/bash
# rm ${USER_HOME}/log/possible_prohibited_files.log
USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)


touch ${USER_HOME}/log/possible_prohibited_files.log

printf "\nPossible prohibited images:\n\n" >> ${USER_HOME}/log/possible_prohibited_files.log

find /home -type f -name "*.jpg" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -type f -name "*.jpeg" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -type f -name "*.gif" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -type f -name "*.png" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -type f -name "*.bmp" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -type f -name "*.webp" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.tiff" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.tif" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.rs" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.im1" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.gif" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.jpe" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.rgb" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.xwd" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.xpm" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.ppm" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.pbm" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.pgm" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.pcx" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.ico" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.svg" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.svgz" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.cr2" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.crw" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.nef" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.pef" -type f >> ${USER_HOME}/log/possible_prohibited_files.log

printf "\nPossible prohibited videos:\n\n" >> ${USER_HOME}/log/possible_prohibited_files.log

find /home -type f -name "*.mp4" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -type f -name "*.mov" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -type f -name "*.wmv" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -type f -name "*.avi" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -type f -name "*.mkv" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.mpeg" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.mpg" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.mpe" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.dl" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.movie" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.movi" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.mv" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.iff" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.anim5" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.anim3" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.anim7" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.vfw" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.avx" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.fli" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.flc" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.mov" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.qt" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.spl" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.swf" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.dcr" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.dir" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.dxr" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.rpm" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.rm" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.smi" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.ra" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.ram" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.rv" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.wmv" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.asf" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.asx" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.wma" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.wax" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.wmv" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.wmx" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.3gp" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.swf" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.flv" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.m4v" -type f >> ${USER_HOME}/log/possible_prohibited_files.log

printf "\nPossible prohibited audio files:\n\n" >> ${USER_HOME}/log/possible_prohibited_files.log

find /home -type f -name "*.mp3" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -type f -name "*.aac" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -type f -name "*.flac" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -type f -name "*.alac" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -type f -name "*.wav" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -type f -name "*.svgz" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.midi" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.mid" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.mod" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.mp2" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.mpa" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.abs" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.mpega" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.au" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.snd" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.wav" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.aiff" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.aif" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.sid" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.flac" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.ogg" -type f >> ${USER_HOME}/log/possible_prohibited_files.log


printf "\nPossible Prohibited Documents\n\n" >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.psd" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.pdf" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.indd" -type f >> ${USER_HOME}/log/possible_prohibited_files.log
find /home -name "*.ai" -type f >> ${USER_HOME}/log/possible_prohibited_files.log


printf "\nPossible prohibited files"
