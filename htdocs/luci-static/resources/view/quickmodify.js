'use strict';
'ucode';
return L.view.extend({
    render: function() {
        let m, s, o;
        m = new form.Map('quickmodify', '全自动一键改机系统', '针对无盘系统优化。');
        s = m.section(form.TypedSection, 'main', '模式设置');
        s.anonymous = true;
        o = s.option(form.Flag, 'diskless', '无盘系统兼容模式');
        s = m.section(form.NamedSection, 'config', 'quickmodify', '手动操作');
        o = s.option(form.Button, '_btn', '执行一次随机修改');
        o.inputstyle = 'apply';
        o.onclick = function() {
            return L.resolveDefault(L.get('/usr/bin/quickmod_logic.sh random'), null).then(() => alert('已发送请求'));
        };
        return m.render();
    }
});
