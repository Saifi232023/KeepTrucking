/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.keeptrucking.models;


public class Truck {
    private int truckId;
    private String plateNumber;
    private String model;
    private String status;

    public Truck(int truckId, String plateNumber, String model, String status) {
        this.truckId = truckId;
        this.plateNumber = plateNumber;
        this.model = model;
        this.status = status;
    }
    // Getters
    public int getTruckId() { return truckId; }
    public String getPlateNumber() { return plateNumber; }
    public String getModel() { return model; }
    public String getStatus() { return status; }
}