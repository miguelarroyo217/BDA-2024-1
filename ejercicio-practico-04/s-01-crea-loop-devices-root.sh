#!/bin/bash
# @Autor         Miguel Arroyo
# @Fecha         29/08/2023
# @Descripcion   Creación de loop devices

echo "Ejecutando como usuario root"
echo "Creando archivos binarios"

echo "creando directorio disk-images"
mkdir /unam-bda/disk-images

echo "creando archivos binarios"
cd /unam-bda/disk-images

#disk1.img
dd if=/dev/zero of=disk1.img bs=100M count=10
#disk2.img
dd if=/dev/zero of=disk2.img bs=100M count=10
#disk3.img
dd if=/dev/zero of=disk3.img bs=100M count=10

echo "comprobando su creación"
du -sh disk*.img

echo "Creando loop device para disk1.img"
losetup -fP disk1.img
losetup -fP disk2.img
losetup -fP disk3.img

echo "Confirmando la creación de los loop devices"
losetup -a

echo "Dando formato ext4 a los nuevos dispositivos"
mkfs.ext4 disk1.img
mkfs.ext4 disk2.img
mkfs.ext4 disk3.img

echo "Creando los directorios donde los dispositivos serán montados"
mkdir /unam-bda/d01
mkdir /unam-bda/d02
mkdir /unam-bda/d03

#Agregar las siguientes líneas al final del archivo /etc/fstab
#/unam-bda/disk-images/disk1.img /unam-bda/d01 auto loop 0 0
#Agregar al archivo las otras 2 configuraciones (d02 y d03)




