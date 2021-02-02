"""
checklist mananger
"""

import os
import sys

from PySide2.QtGui import QGuiApplication
from PySide2.QtQuickControls2 import QQuickStyle
from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType

from importlib import metadata as importlib_metadata

# Find the name of the module that was used to start the app
app_module = sys.modules['__main__'].__package__

# Retrieve the app's metadata
metadata = importlib_metadata.metadata(app_module)

# define the project root for recource purposes
# for packging, resources will be saved as python byte code
root = os.path.dirname(__file__)
home = os.path.join(os.environ.get("HOME"), metadata.get("App-ID"))
if not os.path.exists(home):
	os.mkdir(home)

# paper engine
class Paper(QQmlApplicationEngine):
	def __init__(self):
		super(Paper, self).__init__()
		self.init_plugins()
		self.init_ui()


	def init_plugins(self):

		from .lib.qrequests import QmlRequest
		from .lib.qjsonstorage import QmlJSONStorage
		from .lib.qjsonstorage import QmlEncryptedJSONStorage

		QmlJSONStorage.DICTIONARY = {
			"$apphome": home
		}

		qmlRegisterType(QmlRequest, "Lib", 1, 0, "Request")
		qmlRegisterType(QmlJSONStorage, "Lib", 1, 0, "JSONStorage")
		qmlRegisterType(QmlEncryptedJSONStorage, "Lib", 1, 0, "EncryptedJSONStorage")

	def init_ui(self):
		self.load(
			os.path.join(root, "resources", "source", "app.qml")
		)

def main():
	app = QGuiApplication(sys.argv)
	app.setApplicationName(metadata.get("Name"))
	
	QQuickStyle.setStyle("Fusion")

	engine = Paper()

	sys.exit(
		app.exec_()
	)
