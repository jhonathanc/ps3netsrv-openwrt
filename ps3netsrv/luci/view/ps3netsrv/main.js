'use strict';
'require view';
'require uci';
'require ui';
'require rpc';
'require form';

const callStatus = rpc.declare({
    object: 'luci',
    method: 'ps3netsrv_status',
    params: [],
});

return view.extend({
    load: function () {
        return Promise.all([
            uci.load('ps3netsrv'),
            this.getStatus()
        ]);
    },

    getStatus: function () {
        // Chama o endpoint definido no controller Lua
        return fetch(L.url('admin/services/ps3netsrv_status'), {
            method: 'GET'
        }).then(r => r.json()).catch(() => ({}));
    },

    render: function (data) {
        const status = data[1] || {};
        const m = new form.Map('ps3netsrv', _('PS3 Net Server'), 
            _('Configure o servidor PS3 Net Server.')
        );

        const s = m.section(form.NamedSection, 'main', 'ps3netsrv', _('Configurações'));
        s.addremove = false;
        s.anonymous = true;

        // Enable flag
        const enabled = s.option(form.Flag, 'enabled', _('Enable'),
            _('Enable PS3 Net Server on startup'));
        enabled.default = "0";

        // Games directory
        const dir = s.option(form.Value, 'dir', _('Games Directory'),
            _('Root directory containing PS3 games (e.g., /mnt/sda1/PS3)'));
        dir.depends('enabled', '1');
        dir.datatype = 'string';
        dir.placeholder = '/mnt/sda1/PS3';
        dir.validate = function (section_id, value) {
            if (!value || value.trim() === '')
                return _('Directory path cannot be empty');
            if (!value.startsWith('/'))
                return _('Directory path must start with /');
            return true;
        };

        // Port
        const port = s.option(form.Value, 'port', _('Port'),
            _('Port number for PS3 Net Server (default: 38008)'));
        port.datatype = 'port';
        port.placeholder = '38008';
        port.depends('enabled', '1');
        port.validate = function (section_id, value) {
            const num = Number(value);
            if (isNaN(num))
                return _('Port must be a valid number');
            if (num < 1024 || num > 65535)
                return _('Port must be between 1024 and 65535');
            return true;
        };

        // Status card
        const statusBox = E('div', { class: 'cbi-section' }, [
            E('h3', {}, _('Status do Servidor')),
            E('p', {}, _('Estado atual: ') +
                (status.status === 'running'
                    ? _('🟢 Em execução')
                    : _('🔴 Parado'))
            ),
            status.status === 'running' ? E('ul', {}, [
                E('li', {}, _('Port: ') + status.port),
                E('li', {}, _('Directory: ') + status.dir)
            ]) : ''
        ]);

        return E('div', {}, [
            m.render(),
            statusBox
        ]);
    },

    handleSaveApply: function (ev, mode) {
        return this.handleSave(ev).then(() => {
            ui.changes.apply(mode == '0');
        });
    }
});
