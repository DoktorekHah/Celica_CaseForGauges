$fn=1000;

diameterBoxSensor = 58;
diameterBoxCutSensor = diameterBoxSensor - 5.6;
boxWysSensor = 25;

nums = 8; //Ilosc otworow w obudowie
diamaterCutMagnes = diameterBoxSensor-8;
wysBase = 112;
szerBaseDown = 168;
szerBaseUp = 180-szerBaseDown;
grubosc = 1.3;

//wyciecie dla blokady klapki
cutElementSzer = 35;
cutElementWys = 20;

//mocowanie zegarow
mountSzer = 10;
mountDl = 10;
mountWys = 40;

module base(){
    difference(){
        cube([szerBaseDown,wysBase,grubosc]);
        translate([-15,-0.1,-0.1]){
            cube([szerBaseDown+30,42.1,grubosc+0.2]);
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
    translate([57,42,1]){ //podstawka pod obrecz zegara druga
        rotate([90,0,90])
        triangle(szerBaseUp+10,grubosc+4,0.1,szerBaseDown-120);
        }
    translate([0,42,1]){//podstawka pod obrecz zegara pierwsza
        rotate([90,0,90])
        triangle(szerBaseUp+10,grubosc+4,0.1,szerBaseDown-120);
        }
    translate([57*2,42,1]){//podstawka pod obrecz zegara trzecia
        rotate([90,0,90])
        triangle(szerBaseUp+10,grubosc+4,0.1,szerBaseDown-120);
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

module sensorBuild(){
    rotate([10,-10,0])
    translate([1,diameterBoxSensor/2,0]){
        difference(){
            cylinder(h=boxWysSensor,d1 = diameterBoxSensor,d2 = diameterBoxSensor);
            translate([0,0,-0.1]){
                cylinder(h=boxWysSensor+0.2,d1 = diameterBoxCutSensor,d2 = diameterBoxCutSensor);
            } 
        }  
    }
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