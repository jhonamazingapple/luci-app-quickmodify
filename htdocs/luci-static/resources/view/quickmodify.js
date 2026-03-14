'use strict';
'require view';
'require form';
'require rpc';
'require ui';

var callRandomize = rpc.declare({
	object: 'quickmodify',
	method: 'randomize',
	expect: { result: false }
});

return view.extend({
	render: function() {
		var m, s, o;

		m = new form.Map(
			'quickmodify',
			_('Quick Modify'),
			_('Randomize hostname and MAC address.')
		);

		s = m.section(form.NamedSection, 'main', 'main', _('Settings'));
		s.anonymous = true;

		o = s.option(form.Flag, 'diskless', _('Diskless mode compatibility'));
		o.rmempty = false;

		s = m.section(form.NamedSection, 'main', 'main', _('Manual Action'));
		s.anonymous = true;

		o = s.option(form.Button, '_randomize', _('Run random modify once'));
		o.inputstyle = 'apply';
		o.onclick = function() {
			return callRandomize().then(function() {
				ui.addNotification(null, E('p', _('Random modify executed.')));
			}).catch(function(err) {
				ui.addNotification(null, E('p', _('Execution failed: ') + (err ? err.message || err : 'unknown error')));
			});
		};

		return m.render();
	}
});
