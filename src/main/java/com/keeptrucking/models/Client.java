package com.keeptrucking.models;

public class Client {
    private int clientId;
    private String companyName;
    private String contactName; // NEW
    private String phone;
    private String email;

    public Client(int clientId, String companyName, String contactName, String phone, String email) {
        this.clientId = clientId;
        this.companyName = companyName;
        this.contactName = contactName;
        this.phone = phone;
        this.email = email;
    }
    public int getClientId() { return clientId; }
    public String getCompanyName() { return companyName; }
    public String getContactName() { return contactName; }
    public String getPhone() { return phone; }
    public String getEmail() { return email; }
}