function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end

smsmproto = Proto("smsmtag", "Samsung Smart Tag")
smsmtag_data = ProtoField.new("Data", "btcommon.eir_ad.entry.service_data", ftypes.BYTES, nil, base.NONE)

--13 state
smstag_statef = ProtoField.uint8("smstag.state", "State", base.HEX)

--8d1502 age
smstag_agef = ProtoField.uint24("smstag.age", "Age")

--3b793c9d638b48b1 id
smstag_idf = ProtoField.new("Id", "smstag.id", ftypes.BYTES, nil, base.NONE)

--b7 region+flags
smstag_regflf = ProtoField.uint8("smstag.regfl", "Region + Flags", base.HEX)

--000000 reserved
smstag_reservedf = ProtoField.new("Reserved", "smstag.reserved", ftypes.BYTES, nil, base.NONE)

--4e6aac82 sig
smstag_sigf = ProtoField.new("Signature", "smstag.sig", ftypes.BYTES, nil, base.NONE)

smsmproto.fields = { smsmtag_data, smstag_statef, smstag_agef, smstag_idf, smstag_regflf, smstag_reservedf, smstag_sigf }


function smsmproto.dissector(buffer, pinfo, tree)
    --pinfo.cols.protocol = smsmproto.name
    local subtree = tree:add(smsmproto, buffer(), "Samsung Smart Tag Data")
    subtree:add_le(smstag_statef, buffer(0, 1))
    subtree:add_le(smstag_agef, buffer(1, 3))
    subtree:add_le(smstag_idf, buffer(4, 8))
    subtree:add_le(smstag_regflf, buffer(12, 1))
    subtree:add_le(smstag_reservedf, buffer(13, 3))
    subtree:add_le(smstag_sigf, buffer(16, 4))
end

--DissectorTable.new("btcommon.eir_ad.entry.uuid_16", "UUID_16", ftypes.UINT16, base.HEX)
DissectorTable.get("btcommon.eir_ad.entry.uuid"):add(0xfd5a, smsmproto)
DissectorTable.get("btcommon.eir_ad.entry.uuid"):add("fd5a", smsmproto)
