import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11

import "../../scripts/color.js" as ColorJS

Rectangle{
	id: root
	radius: 5
	border.width: 1
	height: (widthRatio === 1) ? (childrenRect.height)+20 : 450
	border.color: (new ColorJS.Color()).strokegray

	property alias source: image.source
	property double widthRatio

	Image{
		x: 10
		y: 10
		id: image
		width: parent.width-20
		height: (widthRatio === 1) ? (sourceSize.height < 500 ? sourceSize.height : 500) : parent.height-20
		source: "../../assets/png/dummy_dp.png"
		fillMode: Image.PreserveAspectCrop
	}
}
