FROM base:dev.lang.jupyter
USER root
RUN  \
    apt get install npm && \
    npm cache clean --force  && \
    npm install -g code-server --registry=https://registry.npm.taobao.org &&\
    cnpm install @coder/node-browser -g
    cnpm install applicationinsights  -g
    cnpm install yauzl -g
    cnpm install yazl -g
    code-server --extensions-dir /home/dev/.vscode-server/extensions --install-extension shardulm94.trailing-spaces && \
    code-server --extensions-dir /home/dev/.vscode-server/extensions --install-extension vscodevim.vim chown -R myuser /home/dev/.vscode-server
    code-server --extensions-dir /home/dev/.vscode-server/extensions --install-extension ms-vscode.cpptools jaycetyle.vscode-gnu-global golang.go

    #&& \
    #rm -rf /usr/bin/code-server /usr/lib/node_modules /root/.npm /usr/local/share/.cache/yarn

#RUN apk add -q --update --progress --no-cache --virtual codeserverdeps npm build-base libx11-dev libxkbfile-dev libsecret-dev python2 && \
#    npm install -g --unsafe-perm @google-cloud/logging@^4.5.2 code-server && \
#    code-server --extensions-dir /home/myuser/.vscode-server/extensions --install-extension shardulm94.trailing-spaces && \
#    chown -R myuser /home/myuser/.vscode-server
#    apk del codeserverdeps && \
#    rm -rf /usr/bin/code-server /usr/lib/node_modules /root/.npm /usr/local/share/.cache/yarn

USER dev
