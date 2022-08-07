/*
 * Copyright (C) 2022  Your FullName
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * example-hello is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.4

//adding sensor
import QtPositioning 5.2
import QtSensors 5.2

//adding sql
import QtQuick.LocalStorage 2.0
import "Storage.js" as Storage

//backend (service)
import QtSystemInfo 5.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'example-hello.yourname'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    // Qt function
    function round(number, digits) {
        return Math.round(number*Math.pow(10, digits))/Math.pow(10, digits);
    }
    /*

    // for sql ?
    // Settings file is saved in ~userHome/.config/<applicationName>/<applicationName>.conf  File 
    Settings {
        id:settings
        // flag to show or not the App configuration popup
        property bool isFirstUse : true;
    }

    Component {
        id: appConfigurationDialog
        AppConfiguration{}
    }
    */

    // main page
    Page {
        id:main
        anchors.fill: parent

        header: PageHeader {
        id: header
        title: i18n.tr('Hello, world!')
        }
        //create Label
        Label {
            id: label1
            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                //bottom: parent.bottom
            }
            text: 'Click me'
            //verticalAlignment: Label.AlignVCenter
            horizontalAlignment: Label.AlignHCenter
            
            //create an area for handling mouse events
            MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onPressed: {
                //connect and execute the speak function
                python.call('example.speak', ['Hello World!'], function ( result ) {
                label1.text=result;
                });
            }
            }
        }

        Image {
        id: image
        fillMode: Image.PreserveAspectFit
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

            Python {
                Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('../src/'));
                importModule('example', function () {
                    image.source = 'image://python/image-id-passed-from-qml';
                });
                }

                onError: console.log('Python error: ' + traceback)
            }
        }

        /*
        Tabs {
            //id: tabs
            Tab {
                Column {
                    //id: column1
                    spacing: units.gu(1)
                    anchors {
                        margins: units.gu(2)
                        fill: parent
                        //top: label1.bottom
                        //left: parent.left
                        //right: parent.right
                        //bottom: parent.bottom
                    }
                    // sensor access
                    visible: accelerometer.connectedToBackend
                    Accelerometer {
                        id: accelerometer
                        active: true
                    // row
                    }
                    RowField {
                        title: i18n.tr('x (m/s/s)')
                        text: accelerometer.reading != null ? round(accelerometer.reading.x,1) : '-'
                    }
                    RowField {
                        title: i18n.tr('y (m/s/s)')
                        text: accelerometer.reading != null ? round(accelerometer.reading.y,1) : '-'
                    }
                    RowField {
                        title: i18n.tr('z (m/s/s)')
                        text: accelerometer.reading != null ? round(accelerometer.reading.z,1) : '-'
                    }
                    //verticalAlignment: Label.AlignVCenter
                    //horizontalAlignment: Label.AlignHCenter
                }
            }
        }*/


        Label {
            id: label2
            anchors {
                top: label1.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            /*
            //sensor access
            visible: accelerometer.connectedToBackend
            Accelerometer {
                id: accelerometer
                active: true
            }
            */
            //title: i18n.tr('z (m/s/s)') // doesn't exist in Label !
            /*
            if (accelerometer.reading != null) {
                text: round(accelerometer.reading.x,3)
            }
            else {
                text: 'no accelerometer sensor'
            }
            */
            text: 'no accelerometer sensor'
            //text: accelerometer.reading != null ? round(accelerometer.reading.x,3) : '-'

            verticalAlignment: Label.AlignVCenter
            horizontalAlignment: Label.AlignHCenter

        }
        /*
        /// sql test
        // code executed on application start-up
        Component.onCompleted: {

           if(settings.isFirstUse)
           {
              Storage.createTables();
              Storage.insertDefaultConfigValues();

              PopupUtils.open(appConfigurationDialog);
              //to skyp database creation next application start-up
              settings.isFirstUse = false;

           }else{
              // load saved configuration
              header.title = appLicationTitle+" for city: "+Storage.getConfigParamValue('city');
              temperatureUnitLabel.text = Storage.getConfigParamValue('temperatureUnit');
           }
        }
        */
    }



    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('../src/'));

            importModule('example', function() {
                console.log('module imported');
                python.call('example.speak', ['Hello World!'], function(returnValue) {
                    console.log('example.speak returned ' + returnValue);
                })
            });
        }

        onError: {
            console.log('python error: ' + traceback);
        }
    }
}
