package ru.daa.demo1.model;

public class Manager extends Employee {


    public Manager(double s, String name) {
        super(s, name);
    }

    @Override
    public double zarplata(){
        return 13000;

    }
}
