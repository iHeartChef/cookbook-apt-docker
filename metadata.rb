name 'apt-docker'
maintainer 'St. Isidore de Seville'
maintainer_email 'st.isidore.de.seville@gmail.com'
license 'MIT'
description 'Installs/Configures apt Docker Vendor-Specific Repository'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.0'

source_url 'https://github.com/st-isidore-de-seville/cookbook-apt-docker'
issues_url 'https://github.com/st-isidore-de-seville/cookbook-apt-docker/issues'

recipe 'apt-docker::default', 'Installs/Configures apt Docker Vendor-Specific Repository'

depends 'apt', '~> 2.9'

supports 'debian'
supports 'ubuntu'
