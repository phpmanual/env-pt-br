LANG	  = pt_BR
BASE_DIR  = $(shell pwd)
SVN_DIR   = ${BASE_DIR}/doc-${LANG}
GIT_DIR   = ${BASE_DIR}/web-php
BUILD_DIR = ${BASE_DIR}/.build
PEAR_DIR  = ${BASE_DIR}/.pear
PHD_DIR   = ${BASE_DIR}/.phd

default: help

help:
	@echo ""
	@echo " Please use \`make <target>' where <target> is one of:"
	@echo ""
	@echo " > init    first-time download repositories."
	@echo ""
	@echo ""
	@echo " > sync    sync your repositories with central ones."
	@echo ""
	@echo ""
	@echo " > build   validate and generate compiled documentation."
	@echo ""
	@echo ""
	@echo " > web     run a local webserver serving docs on http://localhost:4000."
	@echo ""
	@echo ""
	@echo "        ====== EXPERIMENTAL ===== ===== ===== ===== ===== ===== ====="
	@echo "          The <target>s below are under testing, use with care"
	@echo "        ===== ===== ===== ===== ===== ===== ====== EXPERIMENTAL ====="
	@echo ""
	@echo ""
	@echo "  x_check_sys_deps     verifies if you have all system dependencies."
	@echo ""
	@echo ""
	@echo "  x_pear_install       installs pear via download in your system. (php is needed)"
	@echo ""
	@echo ""
	@echo "  x_phd_install        installs phd via pear in your system. (pear and php are needed)"
	@echo ""
	@echo ""

###################################################################################################################

.get_svn_repo: .check_svn
	svn checkout https://svn.php.net/repository/phpdoc/modules/doc-pt_BR

.get_git_repo: .check_git
	git clone --depth=1 https://github.com/php/web-php.git ${GIT_DIR}

init: .get_svn_repo .get_git_repo

###################################################################################################################

.svn_update: .check_svn
	svn update ${SVN_DIR}

.git_update: .check_git
	git -C ${GIT_DIR} clean -df && git -C ${GIT_DIR} checkout -- . && git -C ${GIT_DIR} pull

sync: svn_update git_update

###################################################################################################################

.validate_manual: .check_php
	cd ${SVN_DIR} \
		&& php doc-base/configure.php --enable-xml-details --with-lang=${LANG}

.generate_manual: .check_phd
	cd ${SVN_DIR} \
		&& phd --docbook doc-base/.manual.xml --package PHP --format php --output ${BUILD_DIR}/${LANG}

.en_build: .check_php .check_phd
	cd ${SVN_DIR} \
		&& php doc-base/configure.php --enable-xml-details
	cd ${SVN_DIR} \
		&& phd --docbook doc-base/.manual.xml --package PHP --format php --output ${BUILD_DIR}/en

build: .validate_manual .generate_manual .en_build

###################################################################################################################

.symbolic_links:
	@[ -d ${GIT_DIR}/manual/${LANG} ] \
		&& rm -r ${GIT_DIR}/manual/${LANG} || true;
	ln -s ${BUILD_DIR}/${LANG}/php-web ${GIT_DIR}/manual/${LANG};
	@[ -d ${GIT_DIR}/manual/en ] \
		&& rm -r ${GIT_DIR}/manual/en || true;
	ln -s ${BUILD_DIR}/en/php-web ${GIT_DIR}/manual/en;

web: .symbolic_links
	php -S localhost:4000 -t ${GIT_DIR};

###################################################################################################################

x_check_sys_deps:
	@system_dependencies=(svn git pear pear phd curl wget); \
	not_found=(); \
	for dep in $${system_dependencies[@]}; do \
		command -v $${dep} >/dev/null 2>&1 \
			|| not_found[$${#not_found[@]}]=$${dep}; \
	done; \
	echo ""; \
	if [ $${#not_found[@]} -eq 0 ]; then \
		echo "OK: You have all the needed system dependencies."; \
	else \
		echo "ERROR: You don't have all needed system dependencies."; \
		echo "------------------------------------------"; \
		echo ""; \
		echo "These are the not found:"; \
		echo "-----"; \
		printf '> %s\n' "$${not_found[@]}"; \
	fi;
	@echo ""

###################################################################################################################

x_pear_install: .check_php
	@url=http://pear.php.net/go-pear.phar; \
	if type curl &>/dev/null; then \
		curl -qfoLsS ${PEAR_DIR}/go-pear.phar $${url}; \
	elif type wget &>/dev/null; then \
		wget -nv $${url} -O ${PEAR_DIR}/go-pear.phar; \
	else \
		echo "error: please install \`curl\` or \`wget\` and try again"; \
		exit 1; \
	fi;
	php -d detect_unicode=0 go-pear.phar

x_phd_install: .check_pear .check_git
	@[ -d ${BASE_DIR}/phd ] \
		&& git -C ${BASE_DIR}/phd pull \
		|| git clone http://git.php.net/repository/phd.git;
	cd ${BASE_DIR}/phd \
		&& sudo pear install package.xml package_generic.xml package_php.xml

###################################################################################################################

.check_svn:
	@command -v svn >/dev/null 2>&1 \
		|| { echo >&2 "error: please install \`svn\` and try again"; exit 1; }

.check_git:
	@command -v git >/dev/null 2>&1 \
		|| { echo >&2 "error: please install \`git\` and try again"; exit 1; }

.check_php:
	@command -v php >/dev/null 2>&1 \
		|| { echo >&2 "error: please install \`php\` and try again"; exit 1; }

.check_pear:
	@command -v pear >/dev/null 2>&1 \
		|| { echo >&2 "error: please install \`pear\` and try again"; exit 1; }

.check_phd:
	@command -v phd >/dev/null 2>&1 \
		|| { echo >&2 "error: please install \`phd\` and try again"; exit 1; }
