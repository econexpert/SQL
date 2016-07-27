-- function fills temporary table with csv entries, this time COMTRADE country codes. 
-- erasing previous function if exists
if object_id('dbo.selectcomtradecode') is not null 
begin drop function dbo.selectcomtradecode end
go
-- erasting previous temporary table if exists
if object_id('dbo.matchinglists') is not null 
begin drop table dbo.matchinglists end
go
-- create temporary table to hold country&code list use COMTRADE codes as example
declare @countrylist varchar(max);
declare @codelist varchar(max);
set @codelist = '0,4,8,10,12,16,20,24,28,31,32,36,40,44,48,50,51,52,56,58,60,64,68,70,72,74,76,80,84,86,90,92,96,97,100,104,108,112,116,120,124,129,132,136,140,144,148,152,156,162,166,170,174,175,178,180,184,188,191,192,196,200,203,204,208,212,214,218,221,222,226,230,231,232,233,234,238,239,242,246,251,254,258,260,262,266,268,270,275,276,278,280,288,290,292,296,300,304,308,312,316,320,324,328,332,334,336,340,344,348,352,356,360,364,368,372,376,381,384,388,392,398,400,404,408,410,414,417,418,422,426,428,430,434,440,442,446,450,454,457,458,459,461,462,466,470,471,472,473,474,478,480,484,490,492,496,498,499,500,504,508,512,516,520,524,527,528,530,531,532,533,534,535,536,540,548,554,558,562,566,568,570,574,577,579,580,581,582,583,584,585,586,588,590,591,592,598,600,604,608,612,616,620,624,626,634,636,637,638,642,643,646,647,654,658,659,660,662,666,670,674,678,682,686,688,690,694,697,698,699,702,703,704,705,706,710,711,716,717,720,724,728,729,732,736,740,748,752,757,760,762,764,768,772,776,780,784,788,792,795,796,798,
800,804,807,810,8a18,826,834,835,836,837,838,839,841,842,849,850,854,858,860,862,866,868,876,879,882,886,887,890,891,894,899'
set @countrylist = 'World,Afghanistan,Albania,Antarctica,Algeria,American Samoa,Andorra,Angola,Antigua and Barbuda,Azerbaijan,Argentina,Australia,Austria,Bahamas,Bahrain,Bangladesh,Armenia,Barbados,Belgium,Belgium-Luxembourg,Bermuda,Bhutan,Bolivia (Plurinational State of),Bosnia Herzegovina,Botswana,Bouvet Island,Brazil,Br. Antarctic Terr.,Belize,Br. Indian Ocean Terr.,Solomon Isds,Br. Virgin Isds,Brunei Darussalam,EU-27,Bulgaria,Myanmar,Burundi,Belarus,Cambodia,Cameroon,Canada,Caribbean nes,
Cabo Verde,Cayman Isds,Central African Rep.,Sri Lanka,Chad,Chile,China,Christmas Isds,Cocos Isds,Colombia,Comoros,Mayotte,Congo,Dem. Rep. of the Congo,Cook Isds,Costa Rica,Croatia,Cuba,Cyprus,Czechoslovakia,Czech Rep.,Benin,Denmark,Dominica,Dominican Rep.,Ecuador,Eastern Europe nes,El Salvador,Equatorial Guinea,Fmr Ethiopia,Ethiopia,Eritrea,Estonia,Faeroe Isds,Falkland Isds (Malvinas),South Georgia and the South Sandwich Islands,Fiji,Finland,France,French Guiana,French Polynesia,Fr. South Antarctic Terr.,Djibouti,Gabon,Georgia,Gambia,State of Palestine,Germany,Fmr Dem. Rep. of Germany,Fmr Fed. Rep. of Germany,Ghana,Northern Africa nes,Gibraltar,Kiribati,Greece,Greenland,Grenada,Guadeloupe,Guam,Guatemala,Guinea,Guyana,Haiti,Heard Island and McDonald Islands,Holy See (Vatican City State),Honduras,China, Hong Kong SAR,Hungary,Iceland,India, excl. Sikkim,Indonesia,Iran,Iraq,Ireland,Israel,Italy,Côte dIvoire,Jamaica,Japan,
Kazakhstan,Jordan,Kenya,Dem. Peoples Rep. of Korea,Rep. of Korea,Kuwait,Kyrgyzstan,Lao Peoples Dem. Rep.,Lebanon,Lesotho,Latvia,Liberia,Libya,Lithuania,Luxembourg,China,Macao SAR,Madagascar,Malawi,Sarawak,Malaysia,Peninsula Malaysia,Sabah,Maldives,Mali,Malta,CACM nes,Africa CAMEU region nes,LAIA nes,Martinique,Mauritania,Mauritius,Mexico,Other Asia nes,Europe EU nes,Mongolia,Rep. of Moldova,Montenegro,Montserrat,Morocco,Mozambique,Oman,Namibia,Nauru,Nepal,Oceania, nes,Netherlands,Neth. Antilles,Curaçao,Neth. Antilles and Aruba,Aruba,Saint Maarten,Bonaire,Neutral Zone,New Caledonia,Vanuatu,New Zealand,Nicaragua,Niger,Nigeria,Other Europe, nes,Niue,Norfolk Isds,Other Africa, nes,Norway,N. Mariana Isds,United States Minor Outlying Islands,Fmr Pacific Isds,FS Micronesia,Marshall Isds,Palau,Pakistan,East and West Pakistan,Fmr Panama excl.Canal Zone,Panama,Fmr Panama-Canal-Zone,Papua New Guinea,Paraguay,Peru,Philippines,Pitcairn,Poland,Portugal,Guinea-Bissau,Timor-Leste,Qatar,Rest of America nes,North America and Central America nes,Réunion,Romania,Russian Federation,Rwanda,Ryukyu Isd,Saint Helena,Saint Kitts, Nevis and Anguilla,Saint Kitts and Nevis,Anguilla,Saint Lucia,Saint Pierre and Miquelon,
Saint Vincent and the Grenadines,San Marino,Sao Tome and Principe,Saudi Arabia,Senegal,Serbia,Seychelles,Sierra Leone,Europe EFTA nes,Sikkim,India,Singapore,Slovakia,Viet Nam,Slovenia,Somalia,South Africa,So. African Customs Union,Zimbabwe,Fmr Rhodesia Nyas,Fmr Dem. Yemen,Spain,South Sudan,Sudan,Western Sahara,Fmr Sudan,Suriname,Swaziland,Sweden,Switzerland,Syria,Tajikistan,Thailand,Togo,Tokelau,Tonga,Trinidad and Tobago,United Arab Emirates,Tunisia,Turkey,Turkmenistan,Turks and Caicos Isds,Tuvalu,Uganda,Ukraine,TFYR of Macedonia,Fmr USSR,Egypt,United Kingdom,United Rep. of Tanzania,Fmr Tanganyika,Fmr Zanzibar and Pemba Isd,Bunkers,Free Zones,Special Categories,USA (before 1981),USA,US Misc. Pacific Isds,US Virgin Isds,Burkina Faso,Uruguay,Uzbekistan,Venezuela,Fmr Dem. Rep. of Vietnam,Fmr Rep. of Vietnam,Wallis and Futuna Isds,Western Asia nes,Samoa,Fmr Arab Rep. of Yemen,Yemen,Fmr Yugoslavia,Serbia and Montenegro,
Zambia,Areas nes'

create table dbo.matchinglists (entrynumber int, countryid varchar(7),countryname varchar(75));

-- populate temporary table from strings of data
declare @counter int,@darba int, @entrynumber int; 
set @counter = 1; set @darba = 1;set @entrynumber = 1;
while (@counter <=len(@codelist)) 
begin
	set @darba = charindex(',',@codelist,@counter)
	if (@darba = 0) set @darba = len(@codelist) + 1;
	insert into dbo.matchinglists values (@entrynumber, substring(@codelist,@counter,@darba - @counter),'reserved');
	set @entrynumber = @entrynumber + 1
	set @counter = @darba +1 
end
set @entrynumber = 1; set @counter =1;
while (@counter <=len(@countrylist)) 
begin
	set @darba = charindex(',',@countrylist,@counter)
	if (@darba = 0) set @darba = len(@countrylist) + 1;
	update dbo.matchinglists set countryname = substring(@countrylist,@counter,@darba - @counter) where @entrynumber = entrynumber;
	set @entrynumber = @entrynumber + 1
	set @counter = @darba +1 
end

go

select * from dbo.matchinglists
go

create function selectcomtradecode (@country nvarchar(25))
returns varchar(35)
as
begin 
declare @new varchar(100);
 select @new= (select countryid from dbo.matchinglists where countryname = @country);

 return @new

end 