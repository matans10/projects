#!/bin/python3

import boto3
from time import sleep
import requests
import os

ec2=boto3.resource('ec2')

def deploy_instance(img,num,typ):
    ec2=boto3.resource('ec2')
    instance=ec2.create_instances(
    ImageId=img,
    MinCount=1,
    MaxCount=num,
    InstanceType=typ)
    print("New instance ID: " + instance[0].id)

def show_instances():
    for instance in ec2.instances.all():
        print(instance.id)

while(True):
    menuChoice = input("Menu:\n1.deploy vm\n2.delete vm\n3.start vm\n4.stop vm\n5.reboot vm\n6.show isntances\n")

    if menuChoice == "1":
        img = input("enter the image you want: ")
        num = int(input("enter how many vm you want: "))
        typ = input("enter the tye of v you want: ")
        deploy_instance(img,num,typ)

    elif menuChoice == "2":
        ids = []
        for i in range(int(input("how many vm you want to delete? "))):
            ids.append(input("enter vm id: "))
        ec2.instances.filter(InstanceIds = ids).terminate()

    elif menuChoice == "3":
        ids = []
        for i in range(int(input("how many vm you want to start? "))):
            ids.append(input("enter vm id: "))
        ec2.instances.filter(InstanceIds=ids).start()

    elif menuChoice == "4":
        ids = []
        for i in range(int(input("how many vm you want to stop? "))):
            ids.append(input("enter vm id: "))
        ec2.instances.filter(InstanceIds=ids).stop()

    elif menuChoice == "5":
        ids = []
        for i in range(int(input("how many vm you want to reboot? "))):
            ids.append(input("enter vm id: "))
        ec2.instances.filter(InstanceIds=ids).reboot()

    elif menuChoice == "6":
        print("instances:\n")
        show_instances()

    again = input("do you wabt do exit? press [n/N] to desplay again the menu or any key to exit: ")
    if again != "n" or again != "N":
        break
    else:
        continue
