reset
export NORM="\e[39m"    ; #echo -e "${NORM}Normal output";
export RED="\e[31m"     ; #echo -e "${RED}Red output";
export GRN="\e[32m"     ; #echo -e "${GRN}Green output";
export CYN="\e[36m"     ; #echo -e "${CYN}Cyan output";
export YEL="\e[33m"     ; #echo -e "${YEL}Yellow output";

export RMT_IP=192.168.1.72
export RMT_USR=pi
export RMT_HOST_PASS=pi
export RMT_HOST=${RMT_USR}@${RMT_IP}
export EXECTBL=RPi_helloWorld
export TGT_EXE_PTH=/home/pi/remote-debug
export GDB_PORT=2345

export RPI_PTH=/media/constantine/Work/BOARDS/RASPBERRY
export GDB_PTH=${RPI_PTH}/tools-master/arm-bcm2708/arm-linux-gnueabihf/bin
export PROJECT_PTH=${RPI_PTH}/workspace/RPi_helloWorld

cd ${PROJECT_PTH}
if [[ -d "${PROJECT_PTH}/build" ]]
then
    echo -e "${RED}Clearing 'build' directory${NORM}"
    rm -rf ${PROJECT_PTH}/build/*
else
    echo -e "${YEL}Creating 'build' directory${NORM}"
    mkdir ${PROJECT_PTH}/build
fi
echo -e "${CYN}Switching to the build directory${NORM}"
cd ${PROJECT_PTH}/build

echo -e "${CYN}Building project - 1-st stage${NORM}"
cmake ..
echo -e "${CYN}Building project - 2-nd stage${NORM}"
make

if [ -f "${PROJECT_PTH}/build/$EXECTBL" ]
then
echo -e "${GRN}Build success. Copying ${EXECTBL} to the Raspberry : ${TGT_EXE_PTH}.${NORM}"
sshpass -p "${RMT_HOST_PASS}" \
scp ${EXECTBL} ${RMT_HOST}:${TGT_EXE_PTH}/${EXECTBL}

echo -e "${GRN}Starting GDB server with port ${GDB_PORT}${NORM}"
sshpass -p "${RMT_HOST_PASS}" ssh ${RMT_HOST} << EOF
killall -9 gdbserver && killall -9 gdbserver
gdbserver :${GDB_PORT} ${TGT_EXE_PTH}/${EXECTBL}
EOF
else
    echo -e "${RED}Build failure${NORM}"
fi