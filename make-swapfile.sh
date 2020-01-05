memRamTotal=$(cat /proc/meminfo | grep MemTotal: | grep -oE '[0-9]+')  # get memory size
memRamTotal=$(($memRamTotal / 1000000))  # cast kb to gb

# if no argument has been passed, then swapfile is equal memory ram size times 2
if [ -z "$1" ]
then
	memSwap=$(($memRamTotal * 2))
else
	memSwap=$1
fi

# make swapfile
sudo swapoff -av
sudo rm /swapfile
sudo fallocate -l "$memSwap"G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# SwapTotal
echo "INFO"
grep MemTotal /proc/meminfo
grep SwapTotal /proc/meminfo
grep SwapFree /proc/meminfo

# Create a swapfile with the double of your memory ram
# bash ./make-swapfile.sh 

# Crate a swapfile with a custom size (gigabytes)
# bash ./make-swapfile.sh 30