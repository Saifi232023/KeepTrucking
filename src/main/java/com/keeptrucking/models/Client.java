/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.keeptrucking.models;

public class Client {
    private int clientId;
    private String companyName;
    private String phone;
    private String email;

    public Client(int clientId, String companyName, String phone, String email) {
        this.clientId = clientId;
        this.companyName = companyName;
        this.phone = phone;
        this.email = email;
    }
    public int getClientId() { return clientId; }
    public String getCompanyName() { return companyName; }
    public String getPhone() { return phone; }
    public String getEmail() { return email; }
}