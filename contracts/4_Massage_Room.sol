// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
contract artem {

    struct massagist { 
    string name;
    string age;
    string[] customers;
    uint profit;
}
    massagist[] private worker;

    mapping(string => uint) prices;
    string[] servives;

    function new_worker(string memory name, string memory age) public payable {
       require(bytes(name).length > 0, "Name cannot be left empty!");
       require(bytes(name).length > 0, "Age cannot be left empty!");
        bool exist = true;
        for (uint i = 0; i<worker.length; i++)
        {
            if ((keccak256(abi.encodePacked(name))) == (keccak256(abi.encodePacked(worker[i].name))))
            {
                exist=false;
            }
        }
        require(exist, "already in the system!");
        
        uint256 i2 = worker.length;
        worker.push();
        worker[i2].name = name;
        worker[i2].age = age;
        worker[i2].profit = 0;
    }

    function make_appointment(string memory massagist_name, string memory my_name) public payable {
        require(bytes(massagist_name).length > 0, "massagist name cannot be left empty!");
        require(bytes(my_name).length > 0, "Your name cannot be left empty!");
       
        
        bool flag = false;
        for (uint i = 0; i<worker.length; i++)
        {
            if ((keccak256(abi.encodePacked(worker[i].name))) == (keccak256(abi.encodePacked(massagist_name))))
            {
                worker[i].customers.push(my_name);
                flag = true;
            }
        }
        require(flag, "We don't know this massagist!");
    }


    function new_service(string memory service_name, uint price) public payable {
        require(bytes(service_name).length > 0, "service's name cannot be left empty!");

        bool flag = true;

        for (uint i = 0; i<servives.length; i++)
        {
            if ((keccak256(abi.encodePacked(servives[i]))) == (keccak256(abi.encodePacked(service_name))))
            {
                flag = false;
            }
        }
        require(flag, "Service already exsist!");
        prices[service_name] = price;
        servives.push(service_name);
    }

    function all_massagists() public payable {
        for (uint i = 0; i<worker.length; i++)
        {
            console.log("Massagist ", worker[i].name, " at the age of ", worker[i].age);
            console.log("He(she) earned ", worker[i].profit, "eth");
        }      
    }

    function pricelist() public payable {
        for (uint i = 0; i<servives.length; i++)
        {
            console.log("Servive ", servives[i], " at the price of ", prices[servives[i]]);
        }      
    }

    function massagists_customers(string memory name) public payable {
        require(bytes(name).length > 0, "name cannot be left empty!");

        bool flag = false;
        for (uint i = 0; i<worker.length; i++)
        {
            if ((keccak256(abi.encodePacked(worker[i].name))) == (keccak256(abi.encodePacked(name))))
            {
                flag = true;
            }
        }
        require(flag, "We don't know this massagist!");

        for (uint i = 0; i<worker.length; i++)
        {
            if ((keccak256(abi.encodePacked(worker[i].name))) == (keccak256(abi.encodePacked(name))))
            {
                console.log("Customers of ", worker[i].name);
                for (uint j = 0; j<worker[i].customers.length; j++)
                {
                        console.log("Customer ", worker[i].customers[j]);
                }
            }
        }      
    }

    function pay_to_massagist(string memory massagist_name, uint payment) public payable {
        require(bytes(massagist_name).length > 0, "name cannot be left empty!");
        bool flag = false;
        uint index;
        for (uint i = 0; i<worker.length; i++)
        {
            if ((keccak256(abi.encodePacked(worker[i].name))) == (keccak256(abi.encodePacked(massagist_name))))
            {
                flag = true;
                index = i;
            }
        }
        require(flag, "We don't know this massagist!");

        worker[index].profit += payment;
    }
}