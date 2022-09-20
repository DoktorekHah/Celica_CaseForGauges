$fn=1000;

diameterBoxSensor = 58;
diameterBoxCutSensor = diameterBoxSensor - 5.6;
boxWysSensor = 25;

nums = 8; //Ilosc otworow w obudowie
diamaterCutMagnes = diameterBoxSensor - 8;
wysBase = 112;
szerBaseDown = 168;
szerBaseUp = 180 - szerBaseDown;
grubosc = 1.3;

//wyciecie dla blokady klapki
cutElementSzer = 35;
cutElementWys = 20;

//mocowanie zegarow
mountSzer = 10;
mountDl = 10;
mountWys = 40;

//podstawka obreczy
dlugoscPodstawki = szerBaseDown - 120;
szerokoscPodstawki = grubosc + 4;
wysokoscPodstawki = szerBaseUp + 10;
katPodstawki = 0.1;

//podstawka XYZ
obrecz_pierwsza_x = 2; //RHD 0  | LHD 2
obrecz_druga_x = 59;  //RHD 57  | LHD 59
obrecz_trzecia_x = 59*2; //RHD 57*2  |59*2
obrecz_y = 42;
obrecz_z = 1;

//rotate
rotate_90_obrecz = 90;
rotate_0_obrecz = 0;
module base(){
    difference(){
        cube([szerBaseDown,wysBase,grubosc]);
        translate([-15,-0.1,-0.1]){
            cube([szerBaseDown+30,42.1,grubosc+0.2]);
            }
        translate([27, 48, -2]){ //sruba_podstawki pierwszej LHD = x 25 | LHD = x 27 
            sruba_podstwki_w_podstawie(); 
        }
        translate([84, 48, -2]){ //sruba podstawki drugiej LHD = x 82 | LHD =x 84
            sruba_podstwki_w_podstawie();
        }
        translate([143 , 48, -2]){ //sruba podstawki trzeciej LHD = x 139 | LHD =x 143
            sruba_podstwki_w_podstawie();
        }    
    }
    difference(){
        translate([szerBaseDown,0,0]){
            triangle(szerBaseUp-2,wysBase,0.1,grubosc);
        }
        translate([160,-0.1,-0.1])
            cube([20,42,3]);
    }
    difference(){
        translate([0,0,0]){
            mirror([180,0,0])
            triangle(szerBaseUp-2,wysBase,0.1,grubosc);
        }
        translate([-13,-0.1,-0.1])
            cube([20,42,3]);
    }
    translate([obrecz_druga_x, obrecz_y, obrecz_z]){ //podstawka pod obrecz zegara druga
        podstawka_on_base();
    }
    translate([obrecz_pierwsza_x, obrecz_y, obrecz_z]){//podstawka pod obrecz zegara pierwsza
        podstawka_on_base();
    }
    translate([obrecz_trzecia_x, obrecz_y, obrecz_z]){//podstawka pod obrecz zegara trzecia
        podstawka_on_base();
    }   
}
module triangle(side1,side2,corner_radius,triangle_height){
    translate([corner_radius,corner_radius,0]){
        hull(){
            cylinder(r=corner_radius, h=triangle_height);
            translate([side1-corner_radius*2,0,0])
                cylinder(r=corner_radius, h=triangle_height);
            translate([0,side2-corner_radius*2,0])
                cylinder(r=corner_radius, h=triangle_height);
        }
    }
}
    
module podstawkaObreczy(){
    difference(){
        triangle(wysokoscPodstawki,szerokoscPodstawki, katPodstawki, dlugoscPodstawki);
        translate([6, 5, 25]){
            rotate([90,0,0])
            cylinder(h = 10, d1 = 4, d2 = 4);
       }
    }
}

module podstawka_on_base(){
    rotate([rotate_90_obrecz, rotate_0_obrecz, rotate_90_obrecz])
    difference(){
        podstawkaObreczy();
        translate([-2.5,3,22.8]){ //-2.5,3,22.8
            rotate([-rotate_90_obrecz , rotate_90_obrecz, -rotate_90_obrecz])
            sensorBuild();
        }
    }
}
module sensorBuild(){
    rotate([10,8,11]) //10,-10,0 /LHD 10,8,11
    translate([1,diameterBoxSensor/2,0]){
        difference(){
            cylinder(h=boxWysSensor,d1 = diameterBoxSensor,d2 = diameterBoxSensor);
            translate([0,0,-0.1]){
                cylinder(h=boxWysSensor+0.2,d1 = diameterBoxCutSensor,d2 = diameterBoxCutSensor);
            } 
        }  
    }
    translate([23,29,26]){
        color("red")
        rotate([0,90,0])
        cylinder(h = 7, d1 = 3.9, d2 = 3.9);
    }
}

module sruba_podstwki_w_podstawie(){
    cylinder(h = 10, d1 = 4, d2 = 4);
}

module buildGaugeMount(Y){
    translate([1.2,0,-1]){
        sensorBuild();
    }
    translate([1.2,Y+1,-1]){
        sensorBuild();
    }
    translate([1.2,(Y+1)*2,-1]){
        sensorBuild();
    }
    translate([30,4,73]){
        rotate([270,0,90])
            base();
    }
}
buildGaugeMount(diameterBoxSensor);
//base();