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

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'example-hello.yourname'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    function round(number, digits) {
        return Math.round(number*Math.pow(10, digits))/Math.pow(10, digits);
    }

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
            verticalAlignment: Label.AlignVCenter
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

        Label {
            id: label2
            anchors {
                top: label1.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            //sensor access
            visible: accelerometer.connectedToBackend
            Accelerometer {
                id: accelerometer
                active: true
            }

            //title: i18n.tr('z (m/s/s)') // doesn't exist in Label !
            text: accelerometer.reading != null ? round(accelerometer.reading.x,3) : '-'
            verticalAlignment: Label.AlignVCenter
            horizontalAlignment: Label.AlignHCenter


        }

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
