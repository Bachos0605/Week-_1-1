-- H? và tên: ?? Vi?t Bách
-- Bài 1

create table Campus(
      CampusID varchar2(5) not null,
      CampusName varchar2(100),
      Street varchar2(100),
      City varchar2(100),
      State varchar2(100),
      Zip varchar2(100),
      Phone varchar2(100),
      CampusDiscount decimal(2,2),
      constraint PK_Campus primary key (CampusID)
);

create table Position(
      PositionID varchar2(5) not null,
      Position varchar2(100),
      YearlyMembershipFee decimal(7,2),
      constraint PK_Position primary key (PositionID)
);

create table Members(
      MemberID varchar2(5) not null,
      LastName varchar2(100),
      FirstName varchar2(100),
      CampusAddress varchar2(100),
      CampusPhone varchar2(100),
      CampusID varchar2(5),
      PositionID varchar2(5),
      ContractDuration integer,
      constraint PK_Members primary key (MemberID),
      constraint FK01_Members foreign key (CampusID) references Campus(CampusID),
      constraint FK02_Members foreign key (PositionID) references Position(PositionID)
);


create table Prices(
      FoodItemTypeID number(20) not null,
      MealType varchar2(100),
      MealPrice decimal(7,2),
      constraint PK_Prices primary key (FoodItemTypeID)
);

create table FoodItems(
      FoodItemID varchar2(5) not null,
      FoodItemName varchar2(100),
      FoodItemTypeID number(20),
      constraint PK_FoodItems primary key (FoodItemID),
      constraint FK_FoodItems foreign key (FoodItemTypeID) references Prices(FoodItemTypeID)
);      

create table Orders(
      OrderID varchar2(5) not null,
      MemberID varchar2(5),
      Orderdate varchar2(25),
      constraint PK_Orders primary key (OrderID),
      constraint FK_Orders foreign key (MemberID) references Members(MemberID)
);

create table OrderLine(
      OrderID varchar2(5),
      FoodItemsID varchar2(5),
      Quantity integer,
      constraint PK_OrderLine primary key (OrderID, FoodItemsID),
      constraint FK01_OrderLine foreign key (OrderID) references Orders(OrderID),
      constraint FK02_OrderLine foreign key (FoodItemsID) references FoodItems( FoodItemID)
);

-- Bài 2
-- 1)

insert into Campus values ('1','IUPUI', '425 University Blvd.', 'Indianapolis', 'IN','46202', '317-274-4591',.08);
insert into Campus values ('2','Indiana University', '107 S. Indiana Ave.', 'Bloomington', 'IN','47405', '812-855 4848',.07);
insert into Campus values ('3','Purdue University', '475 Stadium Mall Drive', 'West Lafayette', 'IN', '47907', '765 494-1776',.06);

insert into Position values ('1','Lecturer', 1050.50);
insert into Position values ('2','Associate Professor', 900.50);
insert into Position values ('3','Assistant Professor', 875.50);
insert into Position values ('4','Professor', 700.75);
insert into Position values ('5', 'Full Professor', 500.50);

insert into Members values ('1', 'Ellen', 'Monk', '009 Purnell', '812-123-1234', '2', '5', 12);
insert into Members values ('2', 'Joe', 'Brady', '008 Statford Hall', '765-234-2345', '3', '2', 10);
insert into Members values ('3','Dave', 'Davidson', '007 Purnell', '812-345-3456', '2', '3', 10);
insert into Members values ('4','Sebastian', 'Cole', '210 Rutherford Hall', '765-234-2345', '3', '5', 10);
insert into Members values ('5','Michael', 'Doo', '66C Peobody', '812-548-8956', '2', '1', 10);
insert into Members values ('6','Jerome', 'Clark', 'SL 220', '317-274-9766', '1', '1', 12);
insert into Members values ('7', 'Bob', 'House', 'ET 329', '317-278-9098', '1', '4', 10);
insert into Members values ('8', 'Bridget','Stanley', 'SI 234', '317-274-5678', '1', '1', 12);
insert into Members values ('9','Bradley', 'Wilson', '334 Statford Hall', '765-258-2567', '3', '2', 10); 

-- 2)

create sequence Prices_sequence;
insert into Prices values (Prices_sequence.Nextval,'Beer/Wine', 5.50);
insert into Prices values (Prices_sequence.Nextval, 'Dessert', 2.75);
insert into Prices values (Prices_sequence.Nextval,'Dinner', 15.50);
insert into Prices values (Prices_sequence.Nextval,'Soft Drink', 2.50); 
insert into Prices values (Prices_sequence.Nextval,'Lunch', 7.25);

insert into FoodItems values ('10001', 'Lager', 1);
insert into FoodItems values ('10002', 'Red Wine', 1);
insert into FoodItems values ('10003', 'White Wine', 1);
insert into FoodItems values ('10004', 'Coke', 4);
insert into FoodItems values ('10005', 'Coffee', 4);
insert into FoodItems values ('10006', 'Chicken a la King', 3);
insert into FoodItems values ('10007', 'Rib Steak', 3);
insert into FoodItems values ('10008', 'Fish and Chips', 3);
insert into FoodItems values ('10009', 'Veggie Delight', 3);
insert into FoodItems values ('10010', 'Chocolate Mousse', 2);
insert into FoodItems values ('10011', 'Carrot Cake', 2);
insert into FoodItems values ('10012', 'Fruit Cup', 2);
insert into FoodItems values ('10013', 'Fish and Chips', 5);
insert into FoodItems values ('10014', 'Angus Beef Burger', 5);
insert into FoodItems values ('10015', 'Cobb Salad', 5);

insert into Orders values ('1', '9', 'March 5, 2005');
insert into Orders values ('2', '8', 'March 5, 2005');
insert into Orders values ('3', '7', 'March 5, 2005');
insert into Orders values ('4', '6', 'March 7, 2005');
insert into Orders values ('5', '5', 'March 7, 2005');
insert into Orders values ('6', '4', 'March 10, 2005');
insert into Orders values ('7', '3', 'March 11, 2005');
insert into Orders values ('8', '2', 'March 12, 2005');
insert into Orders values ('9', '1', 'March 13, 2005');

insert into OrderLine values ('1','10001',1);
insert into OrderLine values ('1','10006',1);
insert into OrderLine values ('1','10012',1);
insert into OrderLine values ('2','10004',2);
insert into OrderLine values ('2','10013',1);
insert into OrderLine values ('2','10014',1);
insert into OrderLine values ('3','10005',1);
insert into OrderLine values ('3','10011',1);
insert into OrderLine values ('4','10005',2);
insert into OrderLine values ('4','10004',2);
insert into OrderLine values ('4','10006',1);
insert into OrderLine values ('4','10007',1);
insert into OrderLine values ('4','10010',2);
insert into OrderLine values ('5','10003',1);
insert into OrderLine values ('6','10002',2);
insert into OrderLine values ('7','10005',2);
insert into OrderLine values ('8','10005',1);
insert into OrderLine values ('8','10011',1);
insert into OrderLine values ('9','10001',1);

-- Bài 3
-- 1)
select constraint_name, table_name FROM user_constraints;

-- 2)
select owner, table_name from all_tables;

-- 3)
select sequence_owner, sequence_name from all_sequences;

 -- 4)
select m.FirstName, m.LastName, p.Position, c.CampusName, (p.YearlyMembershipFee/12) as Monthly_Dues
from Members m, Position p, Campus c
where m.PositionID = p.PositionID and m.CampusID = c.CampusID
order by c.CampusName desc, m.LastName asc
 
  

